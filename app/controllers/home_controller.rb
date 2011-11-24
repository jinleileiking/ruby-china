# coding: utf-8  
class HomeController < ApplicationController
  before_filter :require_no_user, :only => [:login, :login_create]
  before_filter :require_user, :only => [:logout,:auth_unbind]
  skip_before_filter :verify_authenticity_token, :only => [:auth_callback]

  def index
    
    unless current_user.blank?
      redirect_to topics_path 
      return
    end
    
    render :stream => true
  end

  def auth_callback
    auth = request.env["omniauth.auth"]  
    redirect_to root_path if auth.blank?

    @user = User.find_from_hash(auth)
    
    if not current_user.blank?
      current_user.authorizations.create(:provider => auth['provider'], :uid => auth['uid']) #Add an auth to existing
      redirect_to edit_user_registration_path, :notice => "成功绑定了 #{auth['provider'].titleize} 帐号。"
    elsif @user
      sign_in @user if !@user.blank?
      redirect_to root_path, :notice => "登陆成功。"
    else
      if !auth['user_info'].blank? and !auth['user_info']['email'].blank? and User.where(:email => auth['user_info']['email']).count > 0
        redirect_to new_user_session_path, :flash => {:warring => "我们在系统中发现有相同邮件的帐号，请先登陆那个帐号后，进入个人设置页面进行绑定。"}
        return
      end
      
      @user = User.create_from_hash(auth) #Create a new user
      sign_in @user if !@user.blank?
      redirect_to root_path,:notice => "欢迎来自 #{auth['provider'].titleize} 的用户，你的帐号已经创建成功。"
    end
  end
  
end
