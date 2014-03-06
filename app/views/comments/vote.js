<% if @vote.valid? %>  
  <% if params[:vote] == "true" %>
    $('#comment_<%= @comment.id %>_arrow_up').css('color', '#2EB82E');
  <% else %>
    $('#comment_<%= @comment.id %>_arrow_down').css('color', '#CC0000');
  <% end %>
  $('#comment_<%= @comment.id %>_votes').html('<%= @comment.total_votes %> Votes');
<% else %>
  $('#comment_<%= @comment.id %>_error').remove();
  $('#comment_<%= @comment.id %>_votes').parent('div').css('background-color', '#ECD6D6');
  $('#comment_<%= @comment.id %>_votes').parent('div').append('<p id="comment_<%= @comment.id %>_error" class="small text-center" style="color: #d9534f;">You can only vote once.</p>');
<% end %>