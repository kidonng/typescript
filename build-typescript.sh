set -e
set -x

pkg=$(mktemp -d pkg.XXXXXXXXXX)
lib=$pkg/lib

echo checking dependencies
pnpm --version
npm --version

divide_1000() {
  # fixed-point math divison by 1000
  if [[ "$1" == "" ]]; then echo 0; return; fi
  a=000$1; a=${a:0: -3}
  while [ "${a:0:1}" = 0 ]; do a=${a:1}; done
  if [ -z "$a" ]; then a=0; fi
  b=000$1; b=${b: -3}
  echo $a.$b
}

size1=$(du -sb node_modules/typescript/ | cut -d$'\t' -f1)

cp -r node_modules/typescript/* $pkg
cp README.md $pkg

rm -r $pkg/bin
rm $lib/{tsserver,typingsInstaller,tsc}.js
rm $lib/{tsserverlibrary,typescriptServices}.{js,d.ts}
rm -r $lib/{cs,de,es,fr,it,ja,ko,pl,pt-br,ru,tr,zh-cn,zh-tw} $pkg/loc

pnpm uglifyjs --compress --mangle --output $lib/typescript.js -- $lib/typescript.js

pushd $pkg
npm pkg set \
	name=@kidonng/typescript \
	version="${1:-0.0.0}" \
	description="A smaller redistribution of TypeScript. x.xxx% of the original size" \
	repository=kidonng/typescript
npm pkg delete bin scripts.prepare homepage bugs

size2=$(du -sb . | cut -d$'\t' -f1)
relative_size=$(divide_1000 $(( size2 * 100 * 1000 / size1)))
echo "relative_size = $size2 / $size1 = ${relative_size}%"

npm pkg set \
	description="A smaller redistribution of TypeScript. ${relative_size}% of the original size" \

if [[ "$1" == "publish" ]]; then
	npm publish --access public
else
	npm pack
fi

echo done $pkg
