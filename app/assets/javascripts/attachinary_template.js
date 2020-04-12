var template = '<ul>\
    <% for(var i=0; i<files.length; i++){ %>\
      <li>\
        <% if(files[i].resource_type == "raw") { %>\
          <div class="raw-file"></div>\
        <% } else { %>\
          <img\
            src="<%= $.cloudinary.url(files[i].public_id, { "version": files[i].version, "format": "jpg", "crop": "fill" }) %>"\
            alt=""  />\
        <% } %>\
        <a href="#" class="btn btn-danger att-btn-eliminar" data-remove="<%= files[i].public_id %>">\
          Eliminar\
        </a>\
      </li>\
    <% } %>\
</ul>';

$.attachinary.config.template = template;
