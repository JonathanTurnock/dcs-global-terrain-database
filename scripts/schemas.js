const { z } = require("zod");

const terrainSchema = z.object({
  type: z.literal("TERRAIN"),
  id: z.string(),
  name: z.string(),
  projection: z.object({
    proj: z.string()
  }),
});

const beaconSchema = z.object({
  type: z.literal("BEACON"),
  beaconId: z.string(),
  callsign: z.string(),
  direction: z.number(),
  name: z.string(),
  frequency: z.number(),
  position: z.array(z.number()),
  sceneObjects: z.array(z.string()),
});

const aerodromeSchema = z.object({
  type: z.literal("AIRBASE"),
  id: z.string(),
  name: z.string()
});

const parkingSchema = z.object({
  type: z.literal("PARKING"),
  id: z.string(),
  airbase: z.string()
})

module.exports = { terrainSchema, beaconSchema, aerodromeSchema };
