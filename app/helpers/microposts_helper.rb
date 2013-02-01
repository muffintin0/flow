module MicropostsHelper

	def original_post_content(micropost)
		str="<div class='well' style='font-size:90%;'>"
		str+= '@'
		str+= link_to(micropost.user.username, micropost.user)
		str += '<br>'
		str += micropost.body_html

		if micropost.original_post
			str += original_post_content(micropost.original_post)
		end	

		str += "<div>"
		str += "<small style='color: gray;'>"
		str += "<i>Created at: #{time_ago_in_words(micropost.created_at)}</i>"
		str += "</small>"
		str += "<span class='pull-right' id='micropost#{micropost.id}_options'>"
		str += link_to("Reposts(#{micropost.reposts.count})", repost_micropost_path(micropost.id), remote:true, class:"micropost_repost_revealer")
		str += "&nbsp;|&nbsp;"
		str += link_to("Comments(#{micropost.comments.count})", micropost_comments_path(micropost.id), remote:true, class:"micropost_comment_revealer")
		if delete_micropost_privilege?(micropost)
			str += "&nbsp;|&nbsp;"
			str += link_to("delete", micropost, :method => :delete, :confirm => "Are you sure to delete the post?", class:'btn btn-small')
		end 
		str += "</span>"
		str += "</div>"

		str += "<div class='micropost_comments' style='margin-top: 10px; display:none;'>"
		str += "<div id='micropost_comments#{micropost.id}_form'>"
		str += render('comments/form',micropost:micropost)
		str += '</div>'
		str += "<div id='micropost_comments#{micropost.id}_info' style='display:none;'></div>"
		str += "<div class='show_micropost_comments#{micropost.id}'></div>"
		str += "</div></div>"
		
		raw(str)
	end


	def micropost_content(micropost, options={originial_post:false})
		#remove the <p></p> tags around the content
		content=micropost.body_html.gsub(/<p>/,'').gsub(/<\/p>/,'') 
		if micropost.original_post
			micropost.original_post.reposts.each do |repost|
				if repost.created_at < micropost.created_at
					content+= ' //'
					content+= link_to('@'+repost.user.username, repost.user)
					content+= ': '
					content+= strip_tags(repost.body_html) 
				end
			end
		end

		content_tag :div, class:"micropost_content" do
			str = "<div>"
			if options[:original_post]
				str+= '@'
				str+= link_to(micropost.user.username, micropost.user)
				str+= '<br>'
			end
			str += content
			if micropost.micropost_images.any?
				image_index=0
				str += "<ul class='thumbnails'>"
				micropost.micropost_images.each do |image|
					image_index+=1
					str += "<li class='span2'>"
					class_name = "#{current_user.username}_micropost#{micropost.id}_images thumbnail"
					str += link_to(image_tag(image.image_url), image.image_url, class: class_name) 
					str += "</li>"
					if image_index%5==0
						str += "</ul>"
						str += "<ul class='thumbnails'>"
					end
				end
				str += "</ul>"
			end
			str += "</div>"

			if micropost.original_post
				str += "<div class='well' style='font-size:95%;'>"
				str += micropost_content(micropost.original_post,{original_post:true})
				str += "</div>"
			end	

			str += "<div>"
			str += "<small style='color: gray;'>"
			str += "<i>Created at: #{time_ago_in_words(micropost.created_at)}</i>"
			str += "</small>"
			str += "<span class='pull-right' id='micropost#{micropost.id}_options'>"
			str += link_to("Reposts(#{micropost.reposts.count})", repost_micropost_path(micropost.id), remote:true, class:"micropost_repost_revealer")
			str += "&nbsp;|&nbsp;"
			str += link_to("Comments(#{micropost.comments.count})", micropost_comments_path(micropost.id), remote:true, class:"micropost_comment_revealer")
			if delete_micropost_privilege?(micropost)
				str += "&nbsp;|&nbsp;"
				str += link_to("delete", micropost, :method => :delete, :confirm => "Are you sure to delete the post?", class:'btn btn-small')
			end 
			str += "</span></div>"

			str += "<div class='micropost_comments' style='margin-top: 10px; display:none;'>"
			str += "<div id='micropost_comments#{micropost.id}_form'>"
			str += render('comments/form',micropost:micropost)
			str += '</div>'
			str += "<div id='micropost_comments#{micropost.id}_info' style='display:none;'></div>"
			str += "<div class='show_micropost_comments#{micropost.id}'></div>"
			str += "</div>"

			raw(str)
		end
	end
end

