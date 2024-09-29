{ python3, ... }:
python3.withPackages (ps: with ps; [
  black

  mypy
  pylint

  python-lsp-server
  python-lsp-black
  pylsp-mypy
  pynvim

  typing-extensions
])
