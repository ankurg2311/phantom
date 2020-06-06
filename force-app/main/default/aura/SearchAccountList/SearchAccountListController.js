({
    Search: function(component, event, helper) {
        var searchField = component.find('searchField');
        var isValueMissing = searchField.get('v.validity').valueMissing;
        // if value is missing show error message and focus on field
        if(isValueMissing) {
            searchField.showHelpMessageIfInvalid();
            searchField.focus();
        }else{
          // else call helper function 
           var childCmp = component.find("childCmp");
            console.log('@@@@@@ '+childCmp);
            childCmp.loadData(); //
        }
    },
    openModel: function(component, event, helper) {
        // for Display Model,set the "isOpen" attribute to "true"
        // 
        var action = component.get("c.getPiklistValues");
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log('@@@@@@  state '+ state);
            if (state === "SUCCESS"){
                var result = response.getReturnValue();
                console.log('@@@@  result  '+ result);
                var plValues = [];
                for(var key in result){
                    console.log('@@@@  key  '+ key);
                    plValues.push({
                        label: key,
                        value: result[key],
                    });
                }
                component.set("v.GenreList", plValues);
                component.set("v.isOpen", true);
            }
        });
        $A.enqueueAction(action);
        
        
    },
    
    closeModel: function(component, event, helper) {
        // for Hide/Close Model,set the "isOpen" attribute to "Fasle"  
        component.set("v.isOpen", false);
    },
    
    likenClose: function(component, event, helper) {
        // Display alert message on the click on the "Like and Close" button from Model Footer 
        // and set set the "isOpen" attribute to "False for close the model Box.
        alert('thanks for like Us :)');
        component.set("v.isOpen", false);
    },
    
    loaFields: function(component, event, helper) {
        var action = component.get("c.getPiklistValues");
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log('@@@@@@  state '+ state);
            if (state === "SUCCESS"){
                var result = response.getReturnValue();
                console.log('@@@@  result  '+ result);
                var plValues = [];
                for(var key in result){
                    console.log('@@@@  key  '+ key);
                    plValues.push({
                        label: key,
                        value: result[key],
                    });
                }
                component.set("v.GenreList", plValues);
            }
        });
        $A.enqueueAction(action);
    },
     
    handleGenreChange: function (component, event, helper) {
        //Get the Selected values   
        var selectedValues = event.getParam("value");
         
        //Update the Selected Values  
        component.set("v.selectedGenreList", selectedValues);
    },
     
    getSelectedGenre : function(component, event, helper){
        //Get selected Genre List on button click 
        var selectedValues = component.get("v.selectedGenreList");
        console.log('Selectd Genre-' + selectedValues);
        component.set("v.loadTable", true);
        component.set("v.isOpen", false);
    }
})