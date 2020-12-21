<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Page extends Model
{
    protected $table   = 'pages';
    protected $guarded = ['created_at', 'updated_at'];

    public function media()
    {
        return $this->morphOne(Media::class, 'mediable');
    }

}
