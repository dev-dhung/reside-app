"""
Walks lib/ and strips the `const` keyword from any constructor invocation that
references one of the dynamic AppColors getters (theme-dependent surfaces and
text). Leaves all other `const` invocations untouched.
"""
import os
import re

DYNAMIC_PROPS = {
    'scaffoldBackground', 'background', 'surface', 'cardBackground',
    'inputBackground', 'primarySurface',
    'textPrimary', 'textSecondary', 'textTertiary',
    'textDark', 'textMedium', 'textLight',
    'divider', 'shadow', 'shadowMedium', 'shimmer',
    'navInactive', 'navBackground', 'navActive',
}


def has_dynamic(s: str) -> bool:
    for p in DYNAMIC_PROPS:
        if f'AppColors.{p}' in s:
            # Must be a property access, not a substring of a longer identifier
            # (e.g. AppColors.scaffoldBackgroundLight wouldn't match because it
            # would have additional letters after, but we still guard with a
            # word boundary check)
            for m in re.finditer(re.escape(f'AppColors.{p}'), s):
                end = m.end()
                if end == len(s) or not (s[end].isalnum() or s[end] == '_'):
                    return True
    return False


def process_file(path: str) -> bool:
    with open(path, 'r', encoding='utf-8') as f:
        content = f.read()

    new_content = content
    pos = 0
    modified = False
    pattern = re.compile(r'\bconst\s+(?=\w+\s*[\(\[])')

    while True:
        m = pattern.search(new_content, pos)
        if not m:
            break
        const_start = m.start()
        const_end = m.end()

        # Now find the constructor call after `const `
        rest_start = const_end
        # Match identifier (qualified or not) before (
        ident_match = re.match(r'\w+(?:\.\w+)?\s*[\(\[]', new_content[rest_start:])
        if not ident_match:
            pos = const_end
            continue
        open_pos = rest_start + ident_match.end() - 1
        open_char = new_content[open_pos]
        close_char = ')' if open_char == '(' else ']'

        depth = 1
        i = open_pos + 1
        in_string = None  # track 'single', "double" or null
        while i < len(new_content) and depth > 0:
            c = new_content[i]
            if in_string:
                if c == '\\' and i + 1 < len(new_content):
                    i += 2
                    continue
                if c == in_string:
                    in_string = None
            else:
                if c in ('"', "'"):
                    in_string = c
                elif c == open_char:
                    depth += 1
                elif c == close_char:
                    depth -= 1
                    if depth == 0:
                        break
            i += 1

        block_end = i + 1  # include closing char
        block = new_content[const_start:block_end]

        if has_dynamic(block):
            new_content = new_content[:const_start] + new_content[const_end:]
            modified = True
            pos = const_start
        else:
            pos = const_end

    if modified and new_content != content:
        with open(path, 'w', encoding='utf-8') as f:
            f.write(new_content)
        return True
    return False


def main():
    changed = []
    for root, dirs, files in os.walk('lib'):
        for f in files:
            if f.endswith('.dart'):
                path = os.path.join(root, f)
                if process_file(path):
                    changed.append(path)
    for p in changed:
        print(p)
    print(f'Modified {len(changed)} files')


if __name__ == '__main__':
    main()
