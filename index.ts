import * as semver from "semver";

enum Type {
  major = "major",
  minor = "minor",
  patch = "patch"
}

const help = `
usage: \`bump $type $version\`

- $type must be one of ${Object.values(Type).join(", ")}
- $version must be parseable by semver

eg \`bump major 2.2.2\` -> 3.0.0
`;

const fail = (message: string) => {
  console.log(message);
  console.log(help);
  process.exit(1);
};

const oldVersion = process.argv[process.argv.length - 1];
const typeArg = process.argv[process.argv.length - 2];

if (!oldVersion) {
  fail("Must provide version");
}

if (!typeArg) {
  fail("Must provide type");
}

if (typeArg.endsWith("/node")) {
  fail("BUMP")
}

const type = typeArg.toLowerCase() as Type;

if (!Object.values(Type).includes(type)) {
  fail(`Unsupported type ${type}`);
}

if (!semver.valid(oldVersion)) {
  fail(`Unparseable version ${oldVersion}`);
}

console.log(semver.inc(oldVersion, type));
