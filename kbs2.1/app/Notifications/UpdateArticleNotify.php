<?php

namespace App\Notifications;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Notifications\Messages\MailMessage;
use Illuminate\Notifications\Notification;

class UpdateArticleNotify extends Notification
{
    use Queueable;

    public $article;
    public $user;

    /**
     * Create a new notification instance.
     *
     * @return void
     */
    public function __construct($article, $user)
    {
        //
        $this->article = $article;
        $this->user    = $user;
    }

    /**
     * Get the notification's delivery channels.
     *
     * @param  mixed  $notifiable
     * @return array
     */
    public function via($notifiable)
    {
        return ['mail','database'];
    }

    /**
     * Get the mail representation of the notification.
     *
     * @param  mixed  $notifiable
     * @return \Illuminate\Notifications\Messages\MailMessage
     */
    public function toMail($notifiable)
    {
        return (new MailMessage)
        ->subject('Article updated')
        ->greeting('Hello '.$this->user->first_name, 'User')
        ->line('There is a new update on article , hope you will like it')
        ->line('Article title : '.$this->article->en_title) //Send with post title
        ->action('Read Article' , url('/back/article-details' , $this->article->slug)) //Send with post url
        ->line('Thank you for being with us!');
    }


    public function toDatabase($notifiable)
    {
        return [
           'type' => "Update article",
           'sent_user_id' => $this->user->id,
           'article_id'=>$this->article->id,
           'article_title'=>$this->article->en_title,
        ];
    }

    /**
     * Get the array representation of the notification.
     *
     * @param  mixed  $notifiable
     * @return array
     */
    public function toArray($notifiable)
    {
        return [
            //
        ];
    }
}
