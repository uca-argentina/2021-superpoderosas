Class {
	#name : #OneToOneMove,
	#superclass : #Move,
	#instVars : [
		'playerAffected'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialize }
OneToOneMove >> apply: aBlock at: aBoardGame [
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
