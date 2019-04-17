within AixLib.Fluid.BoilerCHP.ModularCHP;
package OldModels "Old models for development purposes"






  replaceable package Medium_Fuel =
      AixLib.DataBase.CHP.ModularCHPEngineMedia.NaturalGasMixture_TypeAachen
                                                                    constrainedby
  DataBase.CHP.ModularCHPEngineMedia.CHPCombustionMixtureGasNasa
                                annotation(choicesAllMatching=true);
end OldModels;
