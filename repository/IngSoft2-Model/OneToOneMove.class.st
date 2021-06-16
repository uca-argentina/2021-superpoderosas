Class {
	#name : #OneToOneMove,
	#superclass : #Move,
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
OneToOneMove >> apply: aBlock at: aBoardGame [
	aBlock value: self playerAffected.
]
