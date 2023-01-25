const { cosmiconfigSync } = require("cosmiconfig");
const { writeJsonSync, readJsonSync } = require("fs-extra");
const { join } = require("path");
const { featureCollection } = require("@turf/turf");
const debug = require("debug")("gtd");
const Ajv = require("ajv");
const { get, trimStart, split, compact } = require("lodash");
const geoJsonSchema = require("./geojson.schema.json");
const { ValidationError } = require("ajv");
const { terrainSchema, aerodromeSchema, beaconSchema } = require("./schemas");
const { z } = require("zod");

const ajv = new Ajv();

const explorerSync = cosmiconfigSync("gtd");

const result = explorerSync.search();

// @ts-ignore
const { terrains } = result.config;

debug("Building %o", terrains);

terrains.forEach(({ name, features }) => {
  const fc = featureCollection(
    features.flatMap((it) => readJsonSync(join(__dirname, `../${it}`)))
  );

  if (!ajv.validate(geoJsonSchema, fc)) {
    const errors = ajv.errors.map((it) => {
      const [item, ...path] = trimStart(it.instancePath, "/features/").split(
        "/"
      );
      const instance = get(fc.features[+item], path);

      return { ...it, instance };
    });
    throw new ValidationError(errors);
  }

  fc.features.forEach((feature) => {
    const type = z.enum(["TERRAIN", "AIRBASE", "BEACON", "PARKING"]).parse(feature.properties.type);

    switch (type) {
      case "TERRAIN":
        terrainSchema.parse(feature.properties);
        break;
      case "AERODROME":
        aerodromeSchema.parse(feature.properties);
        break;
      case "BEACON":
        beaconSchema.parse(feature.properties);
        break;
    }
  });

  writeJsonSync(join(__dirname, `../terrains/${name}.json`), fc);

  console.log("Features Built!");
});
