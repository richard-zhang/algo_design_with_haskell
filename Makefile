.PHONY: ghcid

ghcid:
	ghcid --command='stack ghci' --test=main --no-title --warnings