<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Comment extends Model
{
    use HasFactory;

    protected $fillable = [
        'post_id','user_id','comment_body','status'
    ];

    public function user()
    {

        return $this->belongsTo(User::class);

    }

    public function getCreatedAtAttribute($date)
    {
        return date('j M, Y', strtotime($date));
    }


    public function getUpdatedAtAttribute($date)
    {
        return date('j M, Y', strtotime($date));
    }
}
