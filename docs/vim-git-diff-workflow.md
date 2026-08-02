# vim git diff workflow

Open every file changed in a given commit/range as vim buffers:

```
vim $(git diff <hash> --name-only)
```

Then diff the current buffer against that commit with fugitive:

```
:Gvdiff <hash>
```
