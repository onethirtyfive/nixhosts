{ python311 }:
python311.withPackages (ps: with ps; [
  black

  mypy
  pylint

  python-lsp-server
  python-lsp-black
  pylsp-mypy
  pynvim

  pandas
  # pandas-stubs

  typing-extensions

  pyserial intelhex
])

