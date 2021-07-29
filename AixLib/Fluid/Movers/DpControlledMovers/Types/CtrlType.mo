within AixLib.Fluid.Movers.DpControlledMovers.Types;
type CtrlType = enumeration(
    dpConst
      "Constant pressure / head control",
    dpVar
      "Variable pressure / head control",
    dpTotal
      "Limit only due mover's characteristic curve");
