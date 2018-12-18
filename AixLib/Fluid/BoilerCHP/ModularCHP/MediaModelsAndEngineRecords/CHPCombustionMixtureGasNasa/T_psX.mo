within AixLib.Fluid.BoilerCHP.ModularCHP.MediaModelsAndEngineRecords.CHPCombustionMixtureGasNasa;
function T_psX
  "Return temperature from pressure, specific entropy and mass fraction"
  extends Modelica.Icons.Function;
  input AbsolutePressure p "Pressure";
  input SpecificEntropy s "Specific entropy";
  input MassFraction[nX] X "Mass fractions of composition";
  output Temperature T "Temperature";
protected
  MassFraction[nX] Xfull = if size(X,1) == nX then X else cat(1,X,{1-sum(X)});
package Internal
    "Solve h(data,T) for T with given h (use only indirectly via temperature_phX)"
  extends Modelica.Media.Common.OneNonLinearEquation;
  redeclare record extends f_nonlinear_Data
      "Data to be passed to non-linear function"
    extends Modelica.Media.IdealGases.Common.DataRecord;
  end f_nonlinear_Data;

  redeclare function extends f_nonlinear
      "Note that this function always sees the complete mass fraction vector"
    protected
  MassFraction[nX] Xfull = if size(X,1) == nX then X else cat(1,X,{1-sum(X)});
  Real[nX] Y(unit="mol/mol")=massToMoleFractions(if size(X,1) == nX then X else cat(1,X,{1-sum(X)}), data.MM)
        "Molar fractions";
  algorithm
    y := s_TX(x,Xfull) - sum(Xfull[i]*Modelica.Constants.R/MMX[i]*
    (if Xfull[i]<Modelica.Constants.eps then Y[i] else
    Modelica.Math.log(Y[i]*p/reference_p)) for i in 1:nX);
      // s_TX(x,X)- data[:].R*X*(Modelica.Math.log(p/reference_p)
      //       + MixEntropy(massToMoleFractions(X,data[:].MM)));
  end f_nonlinear;

  // Dummy definition has to be added for current Dymola
  redeclare function extends solve
  end solve;
end Internal;

algorithm
  T := Internal.solve(s, 200, 6000, p, Xfull, data[1]);
end T_psX;
