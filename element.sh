PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"
ELEMENT=$1

if [[ -z $ELEMENT ]]; then
  echo "Please provide an element as an argument."
else
  
  if [[ ! $ELEMENT =~ ^[0-9]+$ ]]; then
    
    NAME_LENGTH=$(echo -n "$ELEMENT" | wc -m)
    # if [[ $NAME_LENGTH -gt 2 ]]; then
      
      QUERY_RESULT=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE name='$ELEMENT'")
      
      if [[ -z $QUERY_RESULT ]]; then
        echo "Element not found in the database."
      else
        echo "$QUERY_RESULT" | while read _ _ ATOMIC_NUM _ SYMBOL _ NAME _ MASS _ MELT _ BOIL _ TYPE; do
          echo "Element $NAME ($SYMBOL) has atomic number $ATOMIC_NUM. It is a $TYPE, with a mass of $MASS amu. The melting point is $MELT°C and the boiling point is $BOIL°C."
        done
      fi
    else
      
      QUERY_RESULT=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE symbol='$ELEMENT'")
      
      if [[ -z $QUERY_RESULT ]]; then
        echo "Element not found in the database."
      else
        echo "$QUERY_RESULT" | while read _ _ ATOMIC_NUM _ SYMBOL _ NAME _ MASS _ MELT _ BOIL _ TYPE; do
          echo "Element $NAME ($SYMBOL) has atomic number $ATOMIC_NUM. It is a $TYPE, with a mass of $MASS amu. The melting point is $MELT°C and the boiling point is $BOIL°C."
        done
      fi
    fi
  else
    
    QUERY_RESULT=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE atomic_number=$ELEMENT")
    
    if [[ -z $QUERY_RESULT ]]; then
      echo "Element not found in the database."
    else
      echo "$QUERY_RESULT" | while read _ _ ATOMIC_NUM _ SYMBOL _ NAME _ MASS _ MELT _ BOIL _ TYPE; do
        echo "Element $NAME ($SYMBOL) has atomic number $ATOMIC_NUM. It is a $TYPE, with a mass of $MASS amu. The melting point is $MELT°C and the boiling point is $BOIL°C."
      done
    fi
  fi
fi
