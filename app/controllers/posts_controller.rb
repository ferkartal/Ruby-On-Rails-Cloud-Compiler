class PostsController < ApplicationController
  attr_accessor :post
  def index

    @posts = Post.all
  end

  def new

    @post = Post.new
  end

  def create
    @post =Post.new(params[:post])
    user=User.find(session[:user_id])
    @post.us_id= user.id
    if 	@post.save
      redirect_to posts_url(@post.id), :notice => "Your post was saved"
    else
      render "new"
    end
  end
  def edit
    @post = Post.find(params[:id])

  end

  def show
    @post =Post.find(params[:id])
    if FileTest.exists?(@post.us_id.to_s + ".h")
      b = "gcc -c " + @post.us_id.to_s + ".h"+" 2>" +@post.us_id.to_s + "resulth.txt"
      a = "gcc -c " + @post.us_id.to_s + ".c" +" 2>" +@post.us_id.to_s + "result.txt"

      if(system(a)==false||system(b)==false)#compileerror

      else
        a="gcc " + @post.us_id.to_s + ".o -o "+@post.us_id.to_s+ " "+@post.us_id.to_s + ".h"+" 2>" +@post.us_id.to_s + "result1.txt"
        if(system(a)==false)#linkerror
        else
          if
          a="./"+@post.us_id.to_s+">>"+@post.us_id.to_s+"logfile.log"
            if(system(a)==false)

            end
          end
        end
      end
    else
      a = "gcc -c " + @post.us_id.to_s + ".c" +" 2>" +@post.us_id.to_s + "result.txt"

      if(system(a)==false)#compileerror

      else
        a="gcc " + @post.us_id.to_s + ".o -o "+@post.us_id.to_s+" 2>" +@post.us_id.to_s + "result1.txt"
        if(system(a)==false)#linkerror
        else
          if
          a="./"+@post.us_id.to_s+">>"+@post.us_id.to_s+"logfile.log"
            if(system(a)==false)

            end
          end
        end
      end

    end

  end

  def update
    @post=Post.find(params[:id])
    if @post.update_attributes(params[:post])
      redirect_to posts_url(@post.id), :notice => "Your post has been updated"
    else
      render "edit"
    end
  end


  def destroy

    @post=Post.find(params[:id])
    if (post.title.last=='c')
      FileUtils.rm(@post.us_id.to_s+".c")
    else
      FileUtils.rm(@post.us_id.to_s+".h")
    end
    @post.destroy
    redirect_to posts_url(@post.id), :notice => "Your post has been deleted"

  end
end