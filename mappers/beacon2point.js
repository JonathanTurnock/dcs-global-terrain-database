const beacons = require("./__data__/beacons/caucasus.json");
const { point } = require("@turf/turf");

const features = beacons.map(
  ({
    beaconId,
    callsign,
    direction,
    display_name,
    frequency,
    position,
    positionGeo,
    sceneObjects,
  }) => point([positionGeo.longitude, positionGeo.latitude], {
      beaconId,
      callsign,
      direction,
      name: display_name,
      frequency,
      position,
      sceneObjects,
  }))


console.log(JSON.stringify(features, undefined, 2));
