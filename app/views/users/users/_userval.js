$("#first").validate({
         errorPlacement: function (error, element) {
   error.insertAfter(element);
},
  rules:{
           "user[name]":
           {
                // unique: true,
                nameRegex: true,
                required: true ,
                 rangelength: [4,50]
           },

           "user[email]":
                {
                  required: true,
                  email: true
                },

           "user[password]":
           {

                 rangelength: [4,19],
                 pwdRegex: true
           }     
            
  },
  messages:{
           "user[name]":
           {
               // regex: "Helolllllo",
               required:"please enter name first",
               rangelength:"name should be 4 to 50 characters",
           },

           "user[email]":
          {
            required: "cant be blank"
          },

           "user[password]":
           {
            rangelength:"is too short(minimum 4 characters)"

           },
       }
   }

);