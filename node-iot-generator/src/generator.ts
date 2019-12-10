import moment from "moment";

type Coordinates = {
    latitude: number;
    longitude: number;
    altitude: number;
};

type Values = {
    air_temperature: number;
    air_humidity: number;
    wind_speed: number;
    is_raining: boolean;
    illuminance: number;
};

type GeneratedIndication = {
    coordinates: Coordinates;
    values: Values;
    timestamp: string; // yyyy-MM-dd HH:mm:ss.SSSZ
};

const generateValues = () => {
    return {
        air_temperature: 15.7,
        air_humidity: 72.1,
        wind_speed: 5.62,
        is_raining: false,
        illuminance: 5072.134
    };
};

const getRandomCoordinates = () => {
    return {
        latitude: 55.755831,
        longitude: 37.617673,
        altitude: 156.5
    };
};

export const generate = () => {

    return {
        coordinates: getRandomCoordinates(),
        values: generateValues(),
        timstamp: moment(new Date(), "yyyy-MM-dd HH:mm:ss.SSSZ")
    };
};
