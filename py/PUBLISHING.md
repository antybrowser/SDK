# Publishing to PyPI

## Prerequisites

1. **PyPI account**: https://pypi.org/account/register/
2. **API token**: https://pypi.org/manage/account/token/ (create one with scope "Entire account")
3. **twine**: `pip install twine`

## Build

```bash
cd sdk/py
pip install build
python -m build
```

This creates `dist/antybrowser-1.0.1.tar.gz` and `dist/antybrowser-1.0.1-py3-none-any.whl`.

## Publish

```bash
twine upload dist/*
```

Enter `__token__` as username and your PyPI API token as password.

Or use env var:

```bash
TWINE_USERNAME=__token__
TWINE_PASSWORD=pypi-...
twine upload dist/*
```

## Verify

```bash
pip install antybrowser
python -c "from antybrowser import AntybrowserClient; print('OK')"
```

## Version Bumps

```bash
# Edit version in pyproject.toml and antybrowser/__init__.py
# Then rebuild and publish
python -m build && twine upload dist/*
```
