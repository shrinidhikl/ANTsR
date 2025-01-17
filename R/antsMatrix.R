# this file defines the class 'antsMatrix' and its associated methods

setClass( Class = "antsMatrix" , 
	  representation( elementtype = "character" , # C++ type used to represent an element of the matrix
			  pointer = "externalptr" # pointer to the actual image of C++ type 'itk::image< pixeltype , dimension >::Pointer'
			  ) 
	  )

setMethod( f = "initialize" ,
	   signature( .Object = "antsMatrix"
		      ) ,
	   definition = function( .Object , 
	   	      		  elementtype 
				  )
	   	       {
			 .Call( "antsMatrix", 
			 	elementtype
				)
	   	       }
	   )

setMethod( f = "as.data.frame" ,
	   signature( x = "antsMatrix" ) ,
	   definition = function( x )
	   	      	{
			  lst = .Call( "antsMatrix_asList" , x )
			names(lst)[ 1 : (length(lst)-1) ] <- lst[[ length(lst) ]]
			lst[[ length(lst) ]] <- NULL
			return( as.data.frame(lst) )
			}
	   )

setMethod( f = "as.list" ,
	   signature( x = "antsMatrix" ) ,
	   definition = function( x )
	   	      {
			lst = .Call( "antsMatrix_asList" , x )
			names(lst)[ 1 : (length(lst)-1) ] <- lst[[ length(lst) ]]
			lst[[ length(lst) ]] <- NULL
			return( lst )
	   	      }
	   )

setGeneric( name = "as.antsMatrix" ,
	    def = function( object , ... ) standardGeneric( "as.antsMatrix" )
	    )

setMethod( f = "as.antsMatrix" ,
	   signature( object = "list" ) ,
	   definition = function( object , elementtype )
	   	      	{
			  return( .Call( "antsMatrix_asantsMatrix" , object , elementtype ) )
			}
	   )

setMethod( f = "as.antsMatrix" ,
	   signature( object = "data.frame" ) ,
	   definition = function( object , elementtype )
	   	      	{
			  return( .Call( "antsMatrix_asantsMatrix" , as.list( object ) , elementtype ) )
			}
	   )