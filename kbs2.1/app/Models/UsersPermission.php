<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
//use Illuminate\Database\Eloquent\Model;
use Jenssegers\Mongodb\Eloquent\Model;


class UsersPermission extends Model
{
    protected $collection = 'users_permissions';
//    protected $primaryKey = 'user_id';

    use HasFactory;
}
