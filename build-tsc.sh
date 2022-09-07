pkg=$(mktemp -d)
lib=$pkg/lib

cp -r node_modules/typescript/* $pkg

rm $pkg/bin/tsserver
rm $lib/{tsserver,typingsInstaller}.js
rm $lib/{tsserverlibrary,typescriptServices,typescript}.{js,d.ts}
rm -r $lib/{cs,de,es,fr,it,ja,ko,pl,pt-br,ru,tr,zh-cn,zh-tw} $pkg/loc

npx uglify-js --compress --mangle --output $lib/tsc.js -- $lib/tsc.js

pushd $pkg
npm pkg set name=@kidonng/tsc version="${1:-0.0.0}"
npm pkg delete main typings bin.tsserver scripts.prepare
npm pack

if [[ -n "$1" ]]; then
	npm publish --access public
fi
