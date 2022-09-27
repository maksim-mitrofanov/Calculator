#  NOTES

## Drag Gesture Desc
    
    let maxTopOffset: CGFloat ✅
    let minTopOffset: CGFloat ✅
    let extraOffset: CGFloat ~10 / 15
    
    @State var isExpanded: Bool = false ✅
    @State var topOffset: CGFloat = 0 ✅
    
    .onChangeOf(isExpanded) { 
        if isExpanded { topOffset = minTopOffset }
        else { topOffset = maxTopOffset }
    }
    
    .dragGesture {
    
        .onChanged { value in 
            let heightValue = value.height
            
            if isExpanded { 
                if heightValue < 0 && heightValue > minTopOffset - extraOffset { 
                    topOffset = heightValue
                
                }
                else if heighValue > 0  && heightValue < maxTopOffset + extraOffset {
                    topOffset = heightValue
                }
            } else { 
                
            }
        }
        
        .onEnded { value in 
            if isExpanded && 
            
            
        }
    }
}
