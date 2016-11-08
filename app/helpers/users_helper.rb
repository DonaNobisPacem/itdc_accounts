module UsersHelper
  def render_user_accounts
    if @accounts.empty?
      ("<h3>No Entries available.</h3>").html_safe
    else
      ("
        <%= @accounts.each do |account| %>
          <tr>
            <td><%= account.id.to_s.rjust(6, '0') %></td>
            <td><%= account.account_type_desc %></td>
            <td><%= account.beginning_amount %></td>
            <td><%= account.balance %></td>
            <td><%= link_to \"View details\", account %></td>
          </tr>
        <% end %>
      ").html_safe
    end
  end
end
