module SMACCM.INS.Pressure (pressureToHeight, heightToPressure) where

basePressure, baseTemperature, lapseRate, baseAltitude, airGasConstant, g_0, airMass :: Floating a => a
basePressure = 101325 -- Pascals
baseTemperature = 288.15 -- K
lapseRate = -0.0065 -- K/m
baseAltitude = 0 -- m
airGasConstant = 8.31432 --  N-m/mol-K
g_0 = 9.80665 -- m/s/s
airMass = 0.0289644 -- kg/mol

-- | Given a barometric pressure measurement in Pascals, return altitude in meters.
pressureToHeight :: Floating a => a -> a
pressureToHeight pressure = (baseAltitude * lapseRate + baseTemperature / ((pressure / basePressure) ** (airGasConstant * lapseRate / (g_0 * airMass))) - baseTemperature) / lapseRate

-- | Given altitude in meters, return a barometric pressure measurement in Pascals.
heightToPressure :: Floating a => a -> a
heightToPressure height = basePressure * (baseTemperature / (baseTemperature + lapseRate * (height - baseAltitude))) ** (g_0 * airMass / (airGasConstant * lapseRate))
