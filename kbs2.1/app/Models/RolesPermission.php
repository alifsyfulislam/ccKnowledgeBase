<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
//use Illuminate\Database\Eloquent\Model;
use Jenssegers\Mongodb\Eloquent\Model;

class RolesPermission extends Model
{
    protected $collection = 'roles_permissions';
//    protected $primaryKey = 'role_id';
    use HasFactory;
}
