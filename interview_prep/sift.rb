'feline' => 'FeLiNe'
'began' => 'BeGaN'
'physics' => 'PHYSICS'

elems = { 'h', 'he', 'li', ...  }
elems.contains('h')
>> true
elems.contains('xy')
>> false

# Return whether or not s is spellable with members of elems
# input string is only one word, and all alphabetical, and all lowercase
# elems are also all lowercase
# all elems are between 1 and 2 (inclusive) in length
def is_spellable(s)
    prev_char = ""
    
    s.each do |char| 
        if (prev_char != "")
           curr_char = prev_char + char
           
           if (elems.contains(curr_char))
               prev_char = ""
           else
               return false
           end
        end
        
        if (!elems.contains(char))
            prev_char = char
        end
    end
    
    if (prev_char != "")
        false
    else
        true
    end
end

def is_spellable(s)
    if (s.length == 0)
        return true
    end
    
    one_char = s.first
    two_chars = s.first + s[1]
   
   [one_char, two_chars].each do |char|
       # return false if memo contains s.substring(char.length)
      if (elems.contains(char) && is_spellable(s.substring(char.length, s.length)))
          return true
      end
   end
   
   return false
end

what is the worst-case runtime?
what kind of string would give you the worst-case runtime (feel free to make up any elements to illustrate your point)?

's', 'c', 'sc', 'cs'
>> 'scscscscscscqq'



define the recurrence:
let s[i] represent "is s up until index i spellable?"
    s[i] is true iff:
        (elems.contains(s[i]) && s[i - 1]) || (elems.contains(s[i - 1] + s[i]) && s[i - 2])
    s[i] is false iff:
        otherwise



def is_spellable(s)
    solutions = [] #default to false for length of s
    
    if (s.length == 0)
        return true
    end
    
    if (s.length > 0)
        solutions[0] = elems.contains(s[0])
    end
    
    if (s.length > 1)
        solutions[1] = (elems.contains(s[1]) && solutions[0]) || elems.contains(s[0] + s[1])
    end
    
    for i in 2..s.length do
       solutions[i] = (elems.contains(s[i]) && solutions[i - 1]) || 
            (elems.contains(s[i - 1] + s[i]) && solutions[i - 2])
    end
    
    solutions[s.length]
end

