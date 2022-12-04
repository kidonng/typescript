pkg=$(mktemp -d)
lib=$pkg/lib

cp -r node_modules/typescript/* $pkg
cp README.md $pkg

rm -r $pkg/bin
rm $lib/{tsserver,typingsInstaller,tsc}.js
rm $lib/{tsserverlibrary,typescriptServices}.{js,d.ts}
rm -r $lib/{cs,de,es,fr,it,ja,ko,pl,pt-br,ru,tr,zh-cn,zh-tw}

pnpm uglifyjs --compress --mangle --output $lib/typescript.js -- $lib/typescript.js

pushd $pkg
npm pkg set \
	name=@kidonng/typescript \
	version="${1:-0.0.0}" \
	description="A tiny redistribution of TypeScript" \
	repository=kidonng/typescript
npm pkg delete bin scripts.prepare homepage bugs

if [[ -n "$1" ]]; then
	npm publish --access public
else
	npm pack
fi
