$(function()
{
   $('#entri').on('click',function()
   {
       event.preventDefault();
       $.ajax({
           url: '/p',
           success: function(myjson){
               console.log(myjson)
            var resul = JSON.stringify(myjson,null,'\t');
            console.log(resul)
            let tbody =  $('#w3review2');
            tbody.html('');
            tbody.append(`${resul}`)

           }
       })
   })
})