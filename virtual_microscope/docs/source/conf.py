import os
import sys
import django
sys.path.insert(0, os.path.abspath('../..'))
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'VirtualMicroscope.settings')
django.setup()

# Configuration file for the Sphinx documentation builder.
#
# For the full list of built-in configuration values, see the documentation:
# https://www.sphinx-doc.org/en/master/usage/configuration.html

# -- Project information -----------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#project-information

project = 'Microscopio Virtual'
copyright = '2023, PRIS-Lab'
author = 'PRIS-Lab'
release = '1.0.0'
master_doc = 'index'
# -- General configuration ---------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#general-configuration

extensions = [
    'sphinx.ext.autodoc',
    'sphinx.ext.autosummary', 
    'sphinx.ext.intersphinx',
    'sphinx.ext.viewcode'
]

templates_path = ['_templates']
exclude_patterns = []

language = 'es'

# -- Options for HTML output -------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#options-for-html-output

html_theme = 'scrolls'
html_static_path = ['_static']

latex_engine = 'xelatex'  # Utiliza XeLaTeX para admitir fuentes personalizadas

latex_elements = {
    'papersize': 'letterpaper',
    'pointsize': '10pt',
    # 'preamble': r'''
    #     \usepackage{fontspec}
    #     \setmainfont{Times New Roman}
    # ''',
}
latex_documents = [
    (master_doc, 'microscopiovirtual.tex', 'Microscopio Virtual Documentation',
     'PRIS-Lab', 'manual'),
]

