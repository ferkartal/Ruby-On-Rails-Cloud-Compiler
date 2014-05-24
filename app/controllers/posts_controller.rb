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
    @post.id= user.id
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

  end

  def update
    @post=Post.find(params[:id])
    if @post.update_attributes(params[:post])
      redirect_to posts_url(@post.id), :notice => "Your post has been updated"
    else
      render "edit"
    end
  end

  def compiler
    user=User.find(session[:user_id])
    @post=Post.find(user.id)
      a = "gcc -c " + @post.id.to_s + ".c" +" 2>" +@post.id.to_s + "result.txt"
      if(system(a)==false)#compileerror

      else
        a="gcc " + @post.id.to_s + ".o -o "+@post.id.to_s+" 2>" +@post.id.to_s + "result1.txt"
        if(system(a)==false)#linkerror
        else
          if
            a="./"+@post.id.to_s+">>"+@post.id.to_s+"logfile.log"
            if(system(a)==false)

            end
          end
        end
      end
#yapilacaklar 1.title eklencek ki doysa isimleri o title a göre 2.sonuclar gösterildikten sonra tüm dosyalar silincek

  end

  def destroy

    @post=Post.find(params[:id])
    FileUtils.rm(@post.id+".c")
    @post.destroy
    redirect_to posts_url(@post.id), :notice => "Your post has been deleted"

  end
end
