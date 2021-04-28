"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestIngSoftModel,
	#superclass : #PackageManifest,
	#category : #'IngSoft2-Model-Manifest'
}

{ #category : #'code-critics' }
ManifestIngSoftModel class >> ruleRBNotEliminationRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#BoardGame #verifyIfTheGameHasFinished #false)) #'2021-04-28T17:44:50.130883-03:00') #(#(#RGMethodDefinition #(#BoardGame #verifyIfTheGameIsInProcess #false)) #'2021-04-28T17:50:34.193883-03:00') )
]
