#!/bin/sh

if (command -v nvim &> /dev/null); then
    nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
fi