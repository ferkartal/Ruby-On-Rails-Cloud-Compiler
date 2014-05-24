class PostsController < ApplicationController
  def index

    @posts = Post.all
  end

  def new

    @post = Post.new
  end

  def create
    @post =Post.new(params[:post])
    #post[:user_id] = $user_id
    @post.id= $user_id
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


      if(system("gcc -c 2.c 2>result.txt")==false)#compileerror

      else
        if(system("gcc 2.o -o a 2>result1.txt")==false)#linkerror
        else
          if
            output = `./a>>logfile.log`#sonuc
            puts "#{output}"
          end
        end
      end
#yapilacaklar 1.title eklencek ki doysa isimleri o title a göre 2.sonuclar gösterildikten sonra tüm dosyalar silincek

  end

  def destroy

    @post=Post.find(params[:id])
    @post.destroy
    redirect_to posts_url(@post.id), :notice => "Your post has been deleted"

  end
end
