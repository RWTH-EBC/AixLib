within AixLib.Fluid.Actuators.Valves.ExpansionValves.SimpleExpansionValves;
model MetaExpansionValve "Model with metastability degree"


   extends BaseClasses.PartialMetaIsenthalpicExpansionValve;

  //Variables for metastability degree

  Modelica.SIunits.Pressure p_th
    "Pressure at throat";

  parameter Utilities.Types.Choice Choice=AixLib.Fluid.Actuators.Valves.ExpansionValves.Utilities.Types.Choice.Bernoullip_th
    "1:m_flow (Pinl,pOut); 2:m_flow(pInl,p_th)";


equation

  //
  //Bernoulli with Metastability Coefficient
  if (Choice == Utilities.Types.Choice.Bernoullip_th) then
      m_flow^2 = C^2*AThr^2*(2*Medium.density(staInl)*(pInl - p_th));
      p_th = metastabilitycoefficient.p_th;
      //C = flowCoefficient.C;
      C=0.95;
        C_meta = metastabilitycoefficient.C_meta
       "Degree of metastability";

      //
  //Bernoulli equation
  elseif (Choice == Utilities.Types.Choice.Bernoulli) then

      m_flow^2 = AThr^2*C^2*(2*Medium.density(staInl)*(pInl - p_th));
      p_th =  pOut;
    C = flowCoefficient.C;
    //C = 0.95;
    C_meta = 0.5;

    else
      assert(false, "Invalid choice of calculation procedure");
    end if;

    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
              Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end MetaExpansionValve;
