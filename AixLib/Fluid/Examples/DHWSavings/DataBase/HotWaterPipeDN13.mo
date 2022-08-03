within AixLib.Fluid.Examples.DHWSavings.DataBase;
record HotWaterPipeDN13 "For a SFD, copper"
  extends AixLib.DataBase.Pipes.PipeBaseDataDefinition(d_o(displayUnit="mm") = 0.0222,
      d_i(displayUnit="mm") = 0.0127,     d=8900,
    lambda=393,
    c=390);
end HotWaterPipeDN13;
