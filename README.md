# TypeScript

This is a redistribution of [TypeScript](https://github.com/microsoft/TypeScript). It features a smaller bundle size by removing "redundant" files and minifying.

This distribution comes with two packages:

## `@kidonng/tsc` [![install size](https://packagephobia.com/badge?p=@kidonng/tsc)](https://packagephobia.com/result?p=@kidonng/tsc)

```sh
npm install @kidonng/tsc
```

Contains only the `tsc` executable. Install this if:

- Your build process only requires `tsc`
- Your build tools don't actually use `typescript` the package (e.g. [`esbuild`](https://github.com/evanw/esbuild))

## `@kidonng/typescript` [![install size](https://packagephobia.com/badge?p=@kidonng/typescript)](https://packagephobia.com/result?p=@kidonng/typescript)

```sh
npm install typescript@npm:@kidonng/typescript
```

Contains only the `typescript` module. Install this if:

- You `import {stuff} from 'typescript'`
- Your build tools use `typescript` the package (e.g. [`@rollup/plugin-typescript`](https://github.com/rollup/plugins/tree/master/packages/typescript))

Note this package does **not** come with `tsc`. Install `@kidonng/tsc` if you need it as well.

## Motivation

There's only one bad thing about TypeScript: [![install size](https://packagephobia.com/badge?p=typescript)](https://packagephobia.com/result?p=typescript). Every package/project is small until it uses/depends on `typescript`.

TypeScript has been [working on modularization](https://github.com/microsoft/TypeScript/issues/27891) but it is a very slow process. Meanwhile the usage is only soaring. This is an imperfect solution to the issue, but I hope it serves well.

The biggest offender seems to be `tsserver`, which is unnecessary most of the time because your editor already comes with one. Dropping it should be harmless most of the time.

## Comparison with official package

- The target module is minified (for `@kidonng/tsc` it's `tsc`, for `@kidonng/typescript` it's `typescript`)
- Every other module is removed (this includes `tsserver`)
- Localized data and diagnostics messages are also removed
- Everything else is the same

## Questions

**Does this work?**

Both packages have been successfully used to build [Vite](https://github.com/vitejs/vite). This is only preliminary test though. The only effective test is to try it yourself and see if any issue occurs.

**I don't trust you, this looks very fishy.**

As with anything open source, you can build this thing yourself. At the same time I will try hard to make sure this project is safe.

**Are you going to be version-compatible with TypeScript?**

If this is ever proved to a useful and successful idea, sure.
