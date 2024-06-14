# -- Project information -----------------------------------------------------

project = 'CI2406 MPW'
copyright = ''
author = ''


# -- General configuration ---------------------------------------------------

# Add any Sphinx extension module names here, as strings. They can be
# extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
# ones.
extensions = [
  'sphinxcontrib.wavedrom',
  'sphinx.ext.mathjax',
  'sphinx.ext.todo'
]

# Add any paths that contain templates here, relative to this directory.
templates_path = ['_templates']

# List of patterns, relative to source directory, that match files and
# directories to ignore when looking for source files.
# This pattern also affects html_static_path and html_extra_path.
exclude_patterns = [
    'build',
    'Thumbs.db',
    # Files included in other rst files.
    'introduction.rst',
]


# -- Options for HTML output -------------------------------------------------
"""
html_theme_options = {
    'header_links' : [
        ("Home", 'index', False, 'home'),
        ("GitHub", "https://github.com/efabless/caravel", True, 'code'),
    ],
    'hide_symbiflow_links': True,
    'license_url' : 'https://www.apache.org/licenses/LICENSE-2.0',
}
"""
# The theme to use for HTML and HTML Help pages.  See the documentation for
# a list of builtin themes.
#
html_theme = 'sphinx_rtd_theme'

# Add any paths that contain custom static files (such as style sheets) here,
# relative to this directory. They are copied after the builtin static files,
# so a file named "default.css" will overwrite the builtin "default.css".
html_static_path = ['_static']

todo_include_todos = False

numfig = True
