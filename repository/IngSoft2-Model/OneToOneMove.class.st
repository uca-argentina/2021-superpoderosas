Class {
	#name : #OneToOneMove,
	#superclass : #Move,
	#instVars : [
		'playerAffected',
		'currentPlayer'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
OneToOneMove >> apply: aBlock at: aBoardGame [
"mirar"
	aBlock value: self playerAffected.
]

{ #category : #accessing }
OneToOneMove >> currentPlayer [
	^ self subclassResponsibility
]

{ #category : #accessing }
OneToOneMove >> playerAffected [
	^ self subclassResponsibility
]
