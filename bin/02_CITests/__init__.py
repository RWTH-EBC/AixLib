import os 

# Version.
version_path = os.path.abspath(os.path.join(os.path.dirname(__file__), 'VERSION'))
with open(version_path) as f:
    __version__ = f.read().strip()