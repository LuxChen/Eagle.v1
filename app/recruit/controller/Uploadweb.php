<?php
namespace app\recruit\controller;

use \think\Controller;
use \think\Config;
class Uploadweb extends Controller
{
    public function uploadImg(){
        header("Access-Control-Allow-Origin: *");
        $base64 = $this->request->param('dataurl');
        if (preg_match('/^(data:\s*image\/(\w+);base64,)/', $base64, $result)){
            $rpath = $this->request->param('path') ? $this->request->param('path') :  'default'; // 图片存储模块
            $uploadPath = '/' . Config::get('_UPLOAD_PATH_PREFIX_'); // 存到文件位置
            $dates = date('YmdHis');
            $type = $result[2];
            $filepath = '.' . $uploadPath;
            $savepath = '/images/' . $rpath . '/' . date('Ym') . '/' . date('d') . '/';
            // 文件保存路径+文件名称
            $rand=rand(100,999);
            $filename = $filepath . $savepath . $dates.'-'.$rand . ".{$type}";
            $this->saveFile($filename, base64_decode(str_replace($result[1], '', $base64)));
            echo substr($filename, 1);
        }
    }
    private function saveFile($filename, $filecontent)
    {
        if (!file_exists($filename)) {
            mkdir(dirname($filename), 0775, true);
        }
        $local_file = fopen($filename, 'wb');
        if (false !== $local_file) {
            if (false !== fwrite($local_file, $filecontent)) {
                fclose($local_file);
            }
        }
    }
    private function correctImageOrientation($filename)
    {
        if (function_exists('exif_read_data')) { // if function exists
            $exif = exif_read_data($filename);
            //dump($exif);
            if ($exif && isset($exif['Orientation'])) { // 如果有方向信息
                $orientation = $exif['Orientation'];
                if ($orientation != 1) { // 有必要旋转
                    $img = imagecreatefrompng($filename); // imagecreatefromjpeg($filename);
                    $deg = 0;
                    switch ($orientation) {
                        case 3:
                            $deg = 180;
                            break;
                        case 6:
                            $deg = 270;
                            break;
                        case 8:
                            $deg = 90;
                            break;
                    }
                    if ($deg) {
                        $img = imagerotate($img, $deg, 0);
                    }
                    // 将旋转的图 重新保存
                    // imagejpeg($img, $filename, 95);
                    imagepng($img, $filename, 95);
                }
            }
        }
    }
}

?>