# TypeScript

> A tiny redistribution of [TypeScript](https://github.com/microsoft/TypeScript)

- Main modules are minified (`tsc.js` in `@kidonng/tsc` & `typescript.js` in `@kidonng/typescript`)
- Other modules are removed (including `tsserver`)
- Localization data and diagnostics messages are removed

## `@kidonng/tsc` [![install size](https://packagephobia.com/badge?p=@kidonng/tsc)](https://packagephobia.com/result?p=@kidonng/tsc)

```sh
npm install @kidonng/tsc
```

Contains only the `tsc` executable. Choose this if:

- Your build process only requires `tsc`
- Your build tools don't `import {stuff} from 'typescript'` (e.g. [`esbuild`](https://github.com/evanw/esbuild))
- You only use `tsc` for type checking (e.g. `tsc --noEmit`)

## `@kidonng/typescript` [![install size](https://packagephobia.com/badge?p=@kidonng/typescript)](https://packagephobia.com/result?p=@kidonng/typescript)

<details>
<summary>Override in <strong>npm/yarn 1</strong></summary>

```sh
npm install typescript@npm:@kidonng/typescript
```

</details>

<details>
<summary>Override in <strong>pnpm</strong></summary>

Add to `package.json`:

```json
{
  "pnpm": {
    "overrides": {
      "typescript": "npm:@kidonng/typescript@^4.8.3"
    }
  }
}
```

</details>

Contains only the `typescript.js` module. Choose this if:

- Your code `import {stuff} from 'typescript'`
- Your build tools `import {stuff} from 'typescript'` (e.g. [`@rollup/plugin-typescript`](https://github.com/rollup/plugins/tree/master/packages/typescript))
- Your dependencies `import {stuff} from 'typescript'` (e.g. [TypeScript ESLint](https://github.com/typescript-eslint/typescript-eslint))

> **Note**: this package does **NOT** include the `tsc` executable. Install `@kidonng/tsc` as well if you need it.

## Motivation

> Also read [my post on r/javascript](https://www.reddit.com/r/javascript/comments/xcygcc/comment/io7xwa8/)

There's only one bad thing about TypeScript: [![install size](https://packagephobia.com/badge?p=typescript)](https://packagephobia.com/result?p=typescript). Every package/project is small until it uses/depends on `typescript`.

TypeScript has been [working on modularization](https://github.com/microsoft/TypeScript/issues/27891) but it is a very slow process. Meanwhile the usage is only soaring. This is an imperfect solution to the issue, but I hope it serves well.

The biggest offender seems to be `tsserver`, which is unnecessary most of the time because your editor already comes with one. Dropping it should be harmless most of the time.

## Questions

**Is there any compatibility issue?**

It should be a drop-in replacement to the official package. Manual E2E test using the [Vite](https://github.com/vitejs/vite) repository has been successful.

The only compatibility issue is with Yarn 2+ (Berry), which [patches TypeScript](https://github.com/yarnpkg/berry/tree/master/packages/plugin-compat) to solve its own compatibility issues.

**How can I ensure this distribution does not contain malicious code?**

While I'm not credible enough to guarantee anything, the build and publish process is publicly available in GitHub Actions log.

As with anything open source, you can always build this thing yourself.
