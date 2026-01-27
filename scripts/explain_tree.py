#!/usr/bin/env python3
import os
import sys
import ast
from pathlib import Path

# Configuration
IGNORE_DIRS = {
    # VCS
    '.git', '.svn', '.hg', '.bzr',
    # Python
    '__pycache__', '.pytest_cache', '.mypy_cache', '.ruff_cache', '.coverage', 'htmlcov', 
    '.venv', 'venv', 'env', '.env', 'site-packages', 'dist-packages',
    # JS / Web
    'node_modules', 'bower_components',
    # Build / Artifacts
    'target', 'dist', 'build', 'out', 'bin', 'obj',
    # IDE / Tools
    '.idea', '.vscode', '.eclipse', '.settings', '.DS_Store', 'Thumbs.db',
    # CI / CD / Meta
    '.github', '.gitlab', '.circleci',
    # Vendor / 3rd Party
    'vendor', 'extern',
    # Documentation (often verbose)
    'docs', 'docs_src', 'doc'
}

IGNORE_FILES = {
    '.DS_Store', '.gitignore', '.gitattributes', 
    '__init__.py', # Often noise in file trees
    '.keep', '.gitkeep'
}

# Normalize ignores to lowercase for case-insensitive matching
IGNORE_DIRS_LOWER = {d.lower() for d in IGNORE_DIRS}
IGNORE_FILES_LOWER = {f.lower() for f in IGNORE_FILES}

# Registry of known descriptions (seeded with project-specific context)
KNOWN_DESCRIPTIONS = {
    ".venv": "Parent virtual environment",
    "app": "Main application code",
    "core": "Core logic (Config, DB, Engine)",
    "config.py": "Central settings & environment",
    "database.py": "SQLite management",
    "engine.py": "FAISS & SentenceTransformer",
    "server.py": "FastAPI Server (REST API)",
    "ingest.py": "Documentation Ingestion Tool",
    "data": "Persistent data (SQLite + FAISS)",
    "docs.db": "SQLite database for docs",
    "my_index.faiss": "Vector search index",
    "scripts": "Utility/Helper scripts",
    "run_server.sh": "Convenient startup script",
    "fastapi": "Your source documentation",
    "server.log": "Current server logs",
    "README.md": "Project documentation",
    "requirements.txt": "Python dependencies",
    "pyproject.toml": "Build system & configuration",
}

def get_description(path: Path):
    """
    Tries to find a description for a file/folder.
    """
    name = path.name
    
    # 1. Check known descriptions
    if name in KNOWN_DESCRIPTIONS:
        return KNOWN_DESCRIPTIONS[name]
    
    if path.is_dir():
        return ""

    # 2 & 3. Parse file content for descriptions
    try:
        # Limit read to first 500 bytes
        try:
            content = path.read_text(encoding='utf-8', errors='ignore')[:1000]
        except Exception:
            return ""

        if path.suffix == '.py':
            try:
                module = ast.parse(content)
                docstring = ast.get_docstring(module)
                if docstring:
                    return docstring.split('\n')[0].strip()
            except Exception:
                pass
            
            lines = content.splitlines()
            for line in lines:
                stripped = line.strip()
                if stripped.startswith('#') and not stripped.startswith('#!'):
                    comment = stripped.lstrip('#').strip()
                    if "coding:" not in comment:
                        return comment
                    break

        if path.suffix == '.sh':
            lines = content.splitlines()
            for line in lines:
                stripped = line.strip()
                if stripped.startswith('#') and not stripped.startswith('#!'):
                    return stripped.lstrip('#').strip()

    except Exception:
        pass

    # 4. Fallbacks
    if path.suffix == '.py': return "Python Source"
    if path.suffix == '.md': return "Documentation"
    if path.suffix == '.json': return "JSON Data"
    if path.suffix == '.log': return "Log File"
    if path.suffix == '.sh': return "Shell Script"
    
    return ""

def generate_tree(dir_path: Path, prefix: str = "", counter: int = 1):
    """
    Recursive generator that yields lines for the tree structure.
    """
    try:
        # Filter entries
        entries = []
        for p in dir_path.iterdir():
            name_lower = p.name.lower()
            if name_lower in IGNORE_DIRS_LOWER:
                continue
            if name_lower in IGNORE_FILES_LOWER:
                continue
            entries.append(p)
            
        # Sort
        entries.sort(key=lambda x: (not x.is_dir(), x.name.lower()))
        
    except PermissionError:
        return counter

    total = len(entries)
    
    for index, entry in enumerate(entries):
        is_last = (index == total - 1)
        
        connector = "└── " if is_last else "├── "
        
        description = get_description(entry)
        desc_str = f"  # {description}" if description else ""
        
        # Print the line
        print(f"{counter:4} {prefix}{connector}{entry.name:<20}{desc_str}")
        
        counter += 1
        
        if entry.is_dir():
            extension = "    " if is_last else "│   "
            counter = generate_tree(entry, prefix + extension, counter)
            
    return counter

def main():
    start_dir = Path.cwd()
    if len(sys.argv) > 1:
        potential_path = Path(sys.argv[1])
        if potential_path.is_dir():
            start_dir = potential_path.resolve()

    print(f"{start_dir.name}/")
    generate_tree(start_dir)

if __name__ == "__main__":
    main()