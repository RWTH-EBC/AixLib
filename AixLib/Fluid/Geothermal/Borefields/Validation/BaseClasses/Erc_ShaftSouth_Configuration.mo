within AixLib.Fluid.Geothermal.Borefields.Validation.BaseClasses;
record Erc_ShaftSouth_Configuration
  "Configuration of the southern shaft of the ERC field"
  extends Data.Configuration.Template(
    borCon=AixLib.Fluid.Geothermal.Borefields.Types.BoreholeConfiguration.DoubleUTubeParallel,
    use_Rb=true,
    Rb=0.2,
    mBor_flow_nominal=0.4,
    mBorFie_flow_nominal=4.8,
    hBor=100,
    dBor=1,
    rBor=0.3,
    rTub=0.032,
    kTub=0.3,
    eTub=0.0029,
    xC=0.05,
    dp_nominal=(100 + (108 + 9)/2)*2 + 10000,
    cooBor={{9*mod((i - 1), 13),9*floor((i - 1)/13)} for i in 1:13},
    mBor_flow_small=1E-4*abs(41.8));

end Erc_ShaftSouth_Configuration;
