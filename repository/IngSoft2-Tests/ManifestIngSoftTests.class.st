"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestIngSoftTests,
	#superclass : #PackageManifest,
	#category : #'IngSoft2-Tests-Manifest'
}

{ #category : #'code-critics' }
ManifestIngSoftTests class >> ruleRBLongMethodsRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#BoardGameTest #testACancellationCardCanAlsoBeUsedByAPlayerIfItIsNotHisTurn #false)) #'2021-06-16T23:46:31.92722-03:00') #(#(#RGMethodDefinition #(#BoardGameTest #testAPlayerUsesADoOverCardWhenTheLastCardPlayedWasACancellationCard #false)) #'2021-06-17T00:05:22.67222-03:00') )
]
